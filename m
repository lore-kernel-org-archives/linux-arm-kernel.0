From: ebiggers@google.com (Eric Biggers)
Date: Wed, 7 Dec 2016 12:23:46 -0800
Subject: [PATCH v3 1/6] crypto: testmgr - avoid overlap in chunked tests
In-Reply-To: <CAKv+Gu_HUjCparJnZXzZR=m3obt+aypibpHrP_ivA==1QNYksg@mail.gmail.com>
References: <1480963348-24203-1-git-send-email-ard.biesheuvel@linaro.org>
 <1480963348-24203-2-git-send-email-ard.biesheuvel@linaro.org>
 <20161207191920.GA139213@google.com>
 <CAKv+Gu_HUjCparJnZXzZR=m3obt+aypibpHrP_ivA==1QNYksg@mail.gmail.com>
Message-ID: <20161207202346.GB125037@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 07:53:51PM +0000, Ard Biesheuvel wrote:
> Does this help at all?
> 
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index 670893bcf361..59e67f5b544b 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -63,7 +63,7 @@ int alg_test(const char *driver, const char *alg,
> u32 type, u32 mask)
>   */
>  #define IDX1           32
>  #define IDX2           32400
> -#define IDX3           511
> +#define IDX3           1511
>  #define IDX4           8193
>  #define IDX5           22222
>  #define IDX6           17101
> 

Yes, with that change made the self-tests pass.

Eric
