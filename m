From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 27 Oct 2016 15:11:21 +0200
Subject: [PATCH] i2c: rk3x: Give the tuning value 0 during
 rk3x_i2c_v0_calc_timings
In-Reply-To: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
References: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <20161027131121.GB1559@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 22, 2016 at 04:43:42PM +0800, David Wu wrote:
> We found a bug that i2c transfer sometimes failed on 3066a board with
> stabel-4.8, the con register would be updated by uninitialized tuning
> value, it made the i2c transfer failed.
> 
> So give the tuning value to be zero during rk3x_i2c_v0_calc_timings.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

What I missed to say in my review:

Please use a subject line that describes WHY the change is needed not so
much WHAT is done. Like: "fix missing initialization causing boot
problems"

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161027/c2981e1f/attachment.sig>
