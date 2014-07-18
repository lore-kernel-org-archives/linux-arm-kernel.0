From: spk.linux@gmail.com (Sachin Kamat)
Date: Fri, 18 Jul 2014 16:58:53 +0530
Subject: [PATCH] cpufreq: tests: Providing cpufreq regression test
In-Reply-To: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
Message-ID: <CAK5sBcH=L-7=BHNPQUjuoQfQx5QeFmBSdwdow+RXBExgCOP0Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

I tested this script on 4210 based Origen board.
This is the output:
./cpufreq_freq_test.sh
CURRENT GOVERNOR: performance
SET GOVERNOR: performance
######################################
TEST AVAILABLE FREQS
######################################
FREQ: 1200000 sleep: invalid number '0.1'
[    5.918347] random: gzip urandom read with 61 bits of entropy available
         OK
FREQ: 1000000 sleep: invalid number '0.1'
         OK
FREQ: 800000 sleep: invalid number '0.1'
         OK
FREQ: 500000 sleep: invalid number '0.1'
         OK
FREQ: 200000 sleep: invalid number '0.1'
         OK
######################################
TEST FREQS SWITCHING
######################################
REFERENCE FREQ: 1200000
FREQ: 1200000 ----> FREQ: 1200000 sleep: invalid number '0.1'
         OK
FREQ: 1200000 ----> FREQ: 1000000 sleep: invalid number '0.1'
         OK
FREQ: 1200000 ----> FREQ: 800000 sleep: invalid number '0.1'
         OK
FREQ: 1200000 ----> FREQ: 500000 sleep: invalid number '0.1'
         OK
FREQ: 1200000 ----> FREQ: 200000 sleep: invalid number '0.1'
         OK
REFERENCE FREQ: 1000000
FREQ: 1000000 ----> FREQ: 1200000 sleep: invalid number '0.1'
         OK
FREQ: 1000000 ----> FREQ: 1000000 sleep: invalid number '0.1'
         OK
FREQ: 1000000 ----> FREQ: 800000 sleep: invalid number '0.1'
         OK
FREQ: 1000000 ----> FREQ: 500000 sleep: invalid number '0.1'
         OK
FREQ: 1000000 ----> FREQ: 200000 sleep: invalid number '0.1'
         OK
REFERENCE FREQ: 800000
FREQ: 800000 ----> FREQ: 1200000 sleep: invalid number '0.1'
         OK
FREQ: 800000 ----> FREQ: 1000000 sleep: invalid number '0.1'
         OK
FREQ: 800000 ----> FREQ: 800000 sleep: invalid number '0.1'
         OK
FREQ: 800000 ----> FREQ: 500000 sleep: invalid number '0.1'
         OK
FREQ: 800000 ----> FREQ: 200000 sleep: invalid number '0.1'
         OK
REFERENCE FREQ: 500000
FREQ: 500000 ----> FREQ: 1200000 sleep: invalid number '0.1'
         OK
FREQ: 500000 ----> FREQ: 1000000 sleep: invalid number '0.1'
         OK
FREQ: 500000 ----> FREQ: 800000 sleep: invalid number '0.1'
         OK
FREQ: 500000 ----> FREQ: 500000 sleep: invalid number '0.1'
         OK
FREQ: 500000 ----> FREQ: 200000 sleep: invalid number '0.1'
         OK
REFERENCE FREQ: 200000
FREQ: 200000 ----> FREQ: 1200000 sleep: invalid number '0.1'
         OK
FREQ: 200000 ----> FREQ: 1000000 sleep: invalid number '0.1'
         OK
FREQ: 200000 ----> FREQ: 800000 sleep: invalid number '0.1'
         OK
FREQ: 200000 ----> FREQ: 500000 sleep: invalid number '0.1'
         OK
FREQ: 200000 ----> FREQ: 200000 sleep: invalid number '0.1'
         OK
######################################
ERRORS: 0
######################################

Though it says 0 errors, what does the "invalid number..." signify?


On Fri, Jul 18, 2014 at 3:53 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> This commit adds first regression test "cpufreq_freq_test.sh" for the
> cpufreq subsystem.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  drivers/cpufreq/tests/README               |  23 +++++
>  drivers/cpufreq/tests/cpufreq_freq_test.sh | 149 +++++++++++++++++++++++++++++
>  2 files changed, 172 insertions(+)
>  create mode 100644 drivers/cpufreq/tests/README
>  create mode 100755 drivers/cpufreq/tests/cpufreq_freq_test.sh
>
> diff --git a/drivers/cpufreq/tests/README b/drivers/cpufreq/tests/README
> new file mode 100644
> index 0000000..66638d2
> --- /dev/null
> +++ b/drivers/cpufreq/tests/README
> @@ -0,0 +1,23 @@
> +This file contains list of cpufreq's available regression tests with a short
> +usage description.
> +
> +1. cpufreq_freq_test.sh
> +
> +Description:
> +------------
> +This test is supposed to test if cpufreq attributes exported by sysfs are

s/test/script would be better

> +exposing a correct values.

s/ exposing a correct values / exposing correct values

> +
> +It can work with or without boost enabled and helps spotting errors related to

s/ helps spotting / helps in spotting

<snip>

> +
> +set +x
> +
> +COLOUR_RED="\33[31m"
> +COLOUR_BLUE="\33[34m"
> +COLOUR_GREEN="\33[32m"
> +COLOUR_DEFAULT="\33[0m"
> +
> +T_PATCH=/sys/devices/system/cpu/cpu0/cpufreq

Shouldn't this be called PATH instead of PATCH?

> +BOOST_PATCH=/sys/devices/system/cpu/cpufreq

ditto and rest of the places in the document.

-- 
Regards,
Sachin.
