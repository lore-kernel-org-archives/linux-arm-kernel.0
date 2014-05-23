From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 21:27:56 +0200
Subject: [PATCH RESEND] ARM: trusted_foundations: fix compile error on
 non-SMP
In-Reply-To: <537F9267.7090304@cogentembedded.com>
References: <1400804612-11876-1-git-send-email-acourbot@nvidia.com>
 <537F9267.7090304@cogentembedded.com>
Message-ID: <201405232127.56481.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014, Sergei Shtylyov wrote:
> > +#if IS_ENABLED(CONFIG_SMP)
> 
>         if (IS_ENABLED(CONFIG_SMP))
> 
> >       setup_max_cpus = 0;
> > +#endif
> 

That wouldn't help to fix the build error when setup_max_cpus is not declared.

	Arnd
