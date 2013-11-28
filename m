From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Nov 2013 16:56:07 +0100
Subject: [PATCH 1/3] pwm: Add mc13xxx pwm driver.
In-Reply-To: <529616A9.2090909@gmail.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
 <529616A9.2090909@gmail.com>
Message-ID: <20131128155606.GC23201@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 04:58:33PM +0100, Philippe R?tornaz wrote:
> Hi
> 
> >+struct mc13xxx *get_mc13xxx(void)
> >+{
> >+	return mc13xxx_data;
> >+}
> >+EXPORT_SYMBOL_GPL(get_mc13xxx);
> >+
> >  int mc13xxx_common_init(struct mc13xxx *mc13xxx,
> >  		struct mc13xxx_platform_data *pdata, int irq)
> >  {
> >@@ -706,6 +714,9 @@ err_revision:
> >  		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
> >  	}
> >
> >+	/* Linux will not have to handle more than one mc13xxx pmic. */
> >+	mc13xxx_data = mc13xxx;
> >+
> 
> Why using a such hack instead of an MFD subdevice ?

I agree, let's not do this please.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/8c371438/attachment-0001.sig>
