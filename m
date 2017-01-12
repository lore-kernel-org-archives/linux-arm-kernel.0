From: drjones@redhat.com (Andrew Jones)
Date: Thu, 12 Jan 2017 18:14:29 +0100
Subject: [kvm-unit-tests PATCH 5/6] docs: mention modifying env vars in
 README
In-Reply-To: <20170111162841.15569-6-alex.bennee@linaro.org>
References: <20170111162841.15569-1-alex.bennee@linaro.org>
 <20170111162841.15569-6-alex.bennee@linaro.org>
Message-ID: <20170112171429.ldiwl7eduxwstgkq@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 04:28:40PM +0000, Alex Benn?e wrote:
> I had started adding a series of flags to control the run-time
> behaviour of the tests but it was pointed out env vars can already do
> that. Mention them in the README so others can find out to.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> ---
>  README.md | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/README.md b/README.md
> index 9462824..fa3a445 100644
> --- a/README.md
> +++ b/README.md
> @@ -47,6 +47,14 @@ environment variable:
>  
>      QEMU=/tmp/qemu/x86_64-softmmu/qemu-system-x86_64 ./x86-run ./x86/msr.flat
>  
> +To force the acceleration mode:
> +
> +    ACCEL=tcg ./run_tests.sh
> +
> +To extend or disable the timeouts:
> +
> +    TIMEOUT=0 ./run_tests.sh
> +

This is a nice addition to the README, but please add more detail.

To force the use of TCG:
 ACCEL=tcg ./run_tests.sh

To force failure when KVM is not present:
 ACCEL=kvm ./run_tests.sh

To modify the timeout:
 TIMEOUT=$DURATION ./run_tests.sh # man timeout(1) for duration format
 TIMEOUT=0 ./run_tests.sh # disable the timeout

or something like that...

thanks,
drew


>  # Contributing
>  
>  ## Directory structure
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
