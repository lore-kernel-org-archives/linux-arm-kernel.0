From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 23 Aug 2017 10:34:20 +0800
Subject: [PATCH] binder: let ANDROID_BINDER_IPC_32BIT be selectable on
 32bit ARM
In-Reply-To: <20170823015108.GA18228@kroah.com>
References: <20170808110305.2748-1-jszhang@marvell.com>
 <20170823015108.GA18228@kroah.com>
Message-ID: <20170823103420.6ffb5ce7@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Aug 2017 18:51:08 -0700 Greg KH wrote:

> On Tue, Aug 08, 2017 at 07:03:05PM +0800, Jisheng Zhang wrote:
> > As noted in commit d0bdff0db809 ("staging: Fix build issues with new
> > binder API"), we can add back the choice for 32bit ARM "once a 64bit
> > __get_user_asm_* implementation is merged." Commit e38361d032f1 ("ARM:
> > 8091/2: add get_user() support for 8 byte types") has added the
> > support, so it's time to let ANDROID_BINDER_IPC_32BIT be selectable on
> > 32bit ARM  
> 
> Ok, but:
> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  drivers/android/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> > index 832e885349b1..aca5dc30b97b 100644
> > --- a/drivers/android/Kconfig
> > +++ b/drivers/android/Kconfig
> > @@ -32,7 +32,7 @@ config ANDROID_BINDER_DEVICES
> >  	  therefore logically separated from the other devices.
> >  
> >  config ANDROID_BINDER_IPC_32BIT
> > -	bool
> > +	bool "Use old (Android 4.4 and earlier) 32-bit binder API"
> >  	depends on !64BIT && ANDROID_BINDER_IPC  
> 
> You don't actually change the depends line :(
> 
> Please fix up, and test it, and then resend.

IHOM, the dependency is correct: 64bit platforms don't support
ANDROID_BINDER_IPC_32BIT. What do you think?

Thanks,
Jisheng
