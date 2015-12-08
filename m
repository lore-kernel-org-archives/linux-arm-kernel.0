From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 08 Dec 2015 13:14:18 -0800
Subject: [PATCH v5 0/4] ARM SMC Calling Convention interface
In-Reply-To: <1449581315-14519-1-git-send-email-jens.wiklander@linaro.org>
 (Jens Wiklander's message of "Tue, 8 Dec 2015 14:28:31 +0100")
References: <1449581315-14519-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <7hoae0k5hx.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

Jens Wiklander <jens.wiklander@linaro.org> writes:

> This patch set is based on the Generic TEE subsystem v6 patchset
> (https://lwn.net/Articles/662495/) sent out a few weeks ago. By isolating
> the ARM SMC Calling Convention patches that are useful for other purposes
> than to support the Generic TEE subsystem some complexity is removed from
> that patch set.
>
> This patch set adds a common interface to do an SMC or HVC following ARM
> SMC Calling Convention. The interface is implemented for both the arm and
> arm64 architectures and updates the PSCI driver to use this interface
> instead for firmware communication.

Build and boot tested on a variety of arm32 and arm64 platforms using
kernelci.org.  The previous THUMB2_KERNEL=y build failures are gone.

Tested-by: Kevin Hilman <khilman@linaro.org>

kernelci.org results:

Build: http://kernelci.org/build/arm-soc/kernel/v4.4-rc3-4-gccfbab1c1ebd/
Boot: http://kernelci.org/boot/all/job/arm-soc/kernel/v4.4-rc3-4-gccfbab1c1ebd/

(NOTE: the boot failures there appear to be lab-related issues, not related tot his patch.)

Kevin
