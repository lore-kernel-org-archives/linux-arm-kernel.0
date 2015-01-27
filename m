From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 12:27:14 +0000
Subject: [PATCH v9 4/5] regulators: axp20x: Change dcdc-workmode DT
 property to boolean flag
In-Reply-To: <1421941147-9682-5-git-send-email-wens@csie.org>
References: <1421941147-9682-1-git-send-email-wens@csie.org>
 <1421941147-9682-5-git-send-email-wens@csie.org>
Message-ID: <20150127122714.GT21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 11:39:06PM +0800, Chen-Yu Tsai wrote:
> The "x-powers,dcdc-workmode" property only has 2 values. A request was
> made to change this to a boolean flag named "x-powers,dcdc-workmode-pwm".
> Given that this particular binding hasn't been used anywhere, it should
> be safe to change.
> 
> Previously the absence of the property meant just keeping the PMIC in
> whatever state was set by the bootloader. After this change, the absence
> means using the "auto" (PWM/PFM hybrid) mode, which is also the hardware's
> default.
> 
> This patch also makes axp20x_set_dcdc_workmode() ignore attempts to set
> the workmode for non-DCDC regulators.

Again I don't understand what this is supposed to accomplish, this seems
to just make the binding less capable by forcing Linux to make a
decision on the configuration rather than allowing it to use the
hardware defaults untouched.  This runs contrary to our normal approach
to regulaors which is to try to avoid touching the hardware unless
explicit configuration is provided to say it's OK which in turn is there
because getting regulators wrong can be such a bad thing for the system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/2607a9fa/attachment.sig>
