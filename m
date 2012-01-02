From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 02 Jan 2012 12:49:35 +0100
Subject: snowball does not compile on linux-next
Message-ID: <4F0199CF.2070806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

the kernel does not compile when
CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK is set.

it fails with :

  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      drivers/clocksource/clksrc-dbx500-prcmu.o
drivers/clocksource/clksrc-dbx500-prcmu.c:61: warning: type defaults
to ?int? in declaration of ?DEFINE_CLOCK_DATA?
drivers/clocksource/clksrc-dbx500-prcmu.c:61: warning: parameter names
(without types) in function declaration
drivers/clocksource/clksrc-dbx500-prcmu.c: In function ?sched_clock?:
drivers/clocksource/clksrc-dbx500-prcmu.c:72: error: implicit
declaration of function ?cyc_to_sched_clock?
drivers/clocksource/clksrc-dbx500-prcmu.c:72: error: ?cd? undeclared
(first use in this function)
drivers/clocksource/clksrc-dbx500-prcmu.c:72: error: (Each undeclared
identifier is reported only once
drivers/clocksource/clksrc-dbx500-prcmu.c:72: error: for each function
it appears in.)
drivers/clocksource/clksrc-dbx500-prcmu.c: In function
?clksrc_dbx500_prcmu_update_sched_clock?:
drivers/clocksource/clksrc-dbx500-prcmu.c:78: error: implicit
declaration of function ?update_sched_clock?
drivers/clocksource/clksrc-dbx500-prcmu.c:78: error: ?cd? undeclared
(first use in this function)
drivers/clocksource/clksrc-dbx500-prcmu.c: In function
?clksrc_dbx500_prcmu_init?:
drivers/clocksource/clksrc-dbx500-prcmu.c:100: error: implicit
declaration of function ?init_sched_clock?
drivers/clocksource/clksrc-dbx500-prcmu.c:100: error: ?cd? undeclared
(first use in this function)
make[2]: *** [drivers/clocksource/clksrc-dbx500-prcmu.o] Error 1
make[1]: *** [drivers/clocksource] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....

Is it dead code ?

Thanks

  -- Daniel

- -- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog    

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPAZnPAAoJEAKBbMCpUGYASZEH/j++IpjESlRymu9JLcTOsc4e
WId52JNiqAkWdkNenstPQu/Rfc7cByR9qYRGKcZH91SvzsMia3fmMRCqCzq4RYgQ
gyWy4wzd881YvlBwnwqHXqeWr8DsKwTvT4fnc0lw/c6HE0paTtWaJ/Zcw0XC4Uv1
skKUht7u1rjZShqXvb9Wb97gXZlbH3JLTdxJpJLG8BV3UjgrbviObdNxyo8hx9hm
hjwXatdynl5AtS9ls3K8lrbFDAi/6FULwD2aliXioda5O9mzpQDMgK6F7yUol2qc
xXgdqDODzpbJGXgbPfrTVb8xgeM60j0SiHhovbWxHVj2t2jBjBzbZ1zJgk06RAM=
=GUyt
-----END PGP SIGNATURE-----
