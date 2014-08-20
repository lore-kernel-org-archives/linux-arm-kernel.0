From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Aug 2014 13:24:06 -0500
Subject: [PATCH v2 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
In-Reply-To: <20140723143323.GA26565@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1404541530-27856-1-git-send-email-peter.griffin@linaro.org>
 <1404541530-27856-2-git-send-email-peter.griffin@linaro.org>
 <20140707124627.GG6407@lee--X1>
 <20140722091800.GB8233@griffinp-ThinkPad-X1-Carbon-2nd>
 <20140722145711.GC20588@saruman.home>
 <20140723143323.GA26565@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20140820182405.GD6023@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 03:33:23PM +0100, Peter Griffin wrote:
> > > > > +	reset_control_assert(dwc3_data->rstc_pwrdn);
> > > > > +
> > > > > +	pinctrl_pm_select_sleep_state(dev);
> > 
> > pinctrl will select sleep and default states automatically for you.
> 
> I've left this in v3, as greping around I couldn't see how that could
> happen automatically.
> 
> Also I just double checked with linusw on irc who confirmed that the
> only state which is ever auto-selected is "default". All other states,
> as well as going back to default state need to be explicitly called.
> 
> Hope thats ok.

yeah, that's fine. Thanks :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/4d485964/attachment.sig>
