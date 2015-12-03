From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Dec 2015 17:59:55 +0000
Subject: [RFC2 PATCH v6 00/19] ILP32 for ARM64
In-Reply-To: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151203175955.GP10747@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 12:16:40AM +0300, Yury Norov wrote:
>  - ILP32 VDSO code excluded. It's not mandatory, and caused questions
>    during review process. We definitely make sure we will follow up
>    with a VDSO later on because it is needed for performance reasons;

I already asked in one of the patches, don't you need a VDSO for
sigreturn?

> The full regression table is:
> 		ILP32		LP64
> 
> float_bessel    FAIL	 134    PASSED	0
> float_exp_log   FAIL	 134    PASSED	0
> float_iperb     FAIL	 134    PASSED	0
> float_power     FAIL	 134    PASSED	0
> float_trigo     FAIL	 134    PASSED	0
> abort01         FAIL       2    FAIL 	2
> fcntl14         FAIL       2    FAIL 	2
> kill11          FAIL       2    FAIL 	2
> mmap16          FAIL       6    PASSED	0
> open12          FAIL       2    PASSED	0
> pause01         PASSED     0    FAIL 	9
> pipe07          FAIL       2    PASSED	0
> readdir01       FAIL       1    PASSED	0
> rename11        FAIL       2    PASSED	0
> rmdir02         FAIL       2    PASSED	0
> setregid02      FAIL       1    FAIL 	1
> settimeofday01  FAIL       1    FAIL 	1
> umount2_01      FAIL       2    PASSED	0
> umount2_02      FAIL       2    PASSED	0
> umount2_03      FAIL       2    PASSED	0
> utime06         FAIL       2    PASSED	0

Have you run any AArch32 LTP with these patches? The results should also
be included in your table above.

-- 
Catalin
