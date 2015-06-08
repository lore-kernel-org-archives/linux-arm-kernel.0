From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Jun 2015 19:07:18 +0100
Subject: [PATCH 5/8] regulator: pwm-regulator: Don't assign structure
 attributes right away
In-Reply-To: <1433529771-24496-6-git-send-email-lee.jones@linaro.org>
References: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
 <1433529771-24496-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20150608180718.GR14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 05, 2015 at 07:42:48PM +0100, Lee Jones wrote:
> Perhaps this is just personal preference, but ...

Possibly...

> Prevents this kind of nonsense:

> 	this->is->just.silly = fetch_silly_value(&pointer);
> 	if (!this->is->just.silly) {
> 		printk("Silly value failed: %d\n", this->is->just.silly);
> 		return this->is->just.silly;
> 	}

But we don't have any of that code?  Well, one if statement where we
check config.init_data but that's it.  A temporary does help with things
like the above but we're not doing that in this driver are we?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150608/50ddba59/attachment.sig>
