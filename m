From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Feb 2016 10:15:10 +0000
Subject: [PATCH] drivers/hwtracing: make coresight-* explicitly non-modular
In-Reply-To: <CANLsYkyY84Tp2oxP9JdAq6WGp9rBXQc=7nXS2hfi9hkcrFEKCw@mail.gmail.com>
References: <1455470351-15219-1-git-send-email-paul.gortmaker@windriver.com>
 <CANLsYkyY84Tp2oxP9JdAq6WGp9rBXQc=7nXS2hfi9hkcrFEKCw@mail.gmail.com>
Message-ID: <20160216101509.GB19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 06:25:56PM -0700, Mathieu Poirier wrote:
> On 14 February 2016 at 10:19, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> > index 9006c4e75cf7..3d8dcdd1aeae 100644
> > --- a/include/linux/amba/bus.h
> > +++ b/include/linux/amba/bus.h
> > @@ -163,4 +163,13 @@ struct amba_device name##_device = {                               \
> >  #define module_amba_driver(__amba_drv) \
> >         module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)
> >
> > +/*
> > + * builtin_amba_driver() - Helper macro for drivers that don't do anything
> > + * special in driver initcall.  This eliminates a lot of boilerplate.  Each
> > + * driver may only use this macro once, and calling it replaces the instance
> > + * device_initcall().
> > + */
> > +#define builtin_amba_driver(__amba_drv) \
> > +       builtin_driver(__amba_drv, amba_driver_register)
> > +
> >  #endif
> > --
> > 2.6.1
> >
> 
> I'm good with this patch on the CS side but Russell maintains the amba
> subsystem and as such needs to agree with the new macro.  Russell, I
> offer to take this through my tree if you're fine with the changes.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
