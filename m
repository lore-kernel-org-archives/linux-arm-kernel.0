From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 9 Feb 2016 16:09:58 +0000
Subject: [PATCH v4 3/3] kallsyms: remove --page-offset command line option
In-Reply-To: <1455030828-6416-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1455030828-6416-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455030828-6416-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <HKXPR06MB056549C714A864B2D4F37DCA8AD60@HKXPR06MB0565.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 Feb 2016, Ard Biesheuvel wrote:

>diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
>index 02473b71643b..32c8d43590af 100644
>--- a/scripts/kallsyms.c
>+++ b/scripts/kallsyms.c
>@@ -63,7 +63,6 @@ static unsigned int table_size, table_cnt;
> static int all_symbols = 0;
> static int absolute_percpu = 0;
> static char symbol_prefix_char = '\0';
>-static unsigned long long kernel_start_addr = 0;
> static int base_relative = 0;



You removed kernel_start_addr, but you didn't remove all the instances of it in the file (you did remove them all in V2 though).

So, now I get:

  CC      scripts/mod/devicetable-offsets.s
../scripts/kallsyms.c: In function 'record_relative_base':
../scripts/kallsyms.c:740:6: error: 'kernel_start_addr' undeclared (first use in this function)
  if (kernel_start_addr > 0) {
      ^
../scripts/kallsyms.c:740:6: note: each undeclared identifier is reported only once for each function it appears in
make[2]: *** [scripts/kallsyms] Error 1


Chris
