From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 23 Jul 2014 10:36:15 +0530
Subject: [PATCH v2] cpufreq: tests: Providing cpufreq regression test
In-Reply-To: <1405926154-27214-1-git-send-email-l.majewski@samsung.com>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
 <1405926154-27214-1-git-send-email-l.majewski@samsung.com>
Message-ID: <CAKohpondk7Cty8MhTcjyzZW8Z0o4AVupYE0rRnG4YJf+SmDyjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

I haven't replied yet as I wanted to see what the general feed of Rafael
is going to be :)

As this is something new and wasn't sure if we really want this..

On 21 July 2014 12:32, Lukasz Majewski <l.majewski@samsung.com> wrote:
> This commit adds first regression test "cpufreq_freq_test.sh" for the
> cpufreq subsystem.

That's not enough, Tell us why we should continue reading this mail..

> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>
> ---
> Changes for v2:
> - Replace *_PATCH with *_PATH for variables names
> - Corrected mistakes in the README file
> - Providing detailed explanation of the patch in the README file
> ---
>  drivers/cpufreq/tests/README               |  33 +++++++
>  drivers/cpufreq/tests/cpufreq_freq_test.sh | 149 +++++++++++++++++++++++++++++

Probably a better place would be tools/power/cpufreq/

@Rafael?

>  2 files changed, 182 insertions(+)
>  create mode 100644 drivers/cpufreq/tests/README
>  create mode 100755 drivers/cpufreq/tests/cpufreq_freq_test.sh
>
> diff --git a/drivers/cpufreq/tests/README b/drivers/cpufreq/tests/README
> new file mode 100644
> index 0000000..3e9cd80
> --- /dev/null
> +++ b/drivers/cpufreq/tests/README
> @@ -0,0 +1,33 @@
> +This file contains list of cpufreq's available regression tests with a short
> +usage description.
> +
> +1. cpufreq_freq_test.sh
> +
> +Description:
> +------------
> +This script is supposed to test if cpufreq attributes exported by sysfs are
> +exposing correct values.
> +
> +To achieve this goal it saves the current governor and changes it to
> +"performance". Afterwards, it reads the "scaling_available_frequencies"
> +property. With the list of supported frequencies it is able to enforce each of
> +them by writing to "scaling_max_freq" attribute. To make the test more reliable
> +a superfluous load with gzip is created to be sure that we are running with
> +highest possible frequency. This high load is regulated with the 'sleep'
> +duration. After this time the "cpufreq_cur_freq" is read and compared with the
> +original value. As the last step the original governor is restored.

I couldn't make out the purpose of this test and why we need it. How do
we ensure that "cpufreq attributes exported by sysfs are exposing
correct values"?

And actually what do we mean by this statement even? What kind of errors can
be there in exposing these values.

I want to understand the purpose of this script very clearly first and then only
will look at the details.
