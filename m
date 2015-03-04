From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 04 Mar 2015 18:30:34 +0100
Subject: [PATCH 3/8] ARM: make xscale iwmmxt code multiplatform aware
In-Reply-To: <356997090.ZkRbrlLqgW@wuerfel> (Arnd Bergmann's message of "Wed,
 04 Mar 2015 15:38:29 +0100")
References: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
 <1425043775-3106827-4-git-send-email-arnd@arndb.de>
 <87pp8ozwb1.fsf@free.fr> <356997090.ZkRbrlLqgW@wuerfel>
Message-ID: <87fv9kzn45.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 04 March 2015 15:12:02 Robert Jarzmik wrote:
>
> I tried to not change the behavior here, and I think you missed this part:
>
> -#if !defined(CONFIG_CPU_XSCALE) && !defined(CONFIG_CPU_XSC3)
> +#if !defined(CONFIG_CPU_XSCALE)
>  #define        cpu_is_xscale() 0
>  #else
> -#define        cpu_is_xscale() 1
>  ...
>
> This means that previously, cpu_is_xscale() returned true for pxa3xx,
> while now it returns false, and I added the "&& !cpu_is_xsc3()" to
> keep the logic the same as before.
>
> Does that make sense?
Ah now yes, I missed the former cpu_is_xscale() behavior, my brain is working in
first gear lately ...

Then the patch looks fine.

Cheers.

-- 
Robert
