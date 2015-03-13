From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 13 Mar 2015 10:03:16 -0700
Subject: [PATCH 0/6] ARM: cpuidle: Unify the ARM64/ARM DT approach
In-Reply-To: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Tue, 3 Mar 2015 13:29:31 +0100")
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <7hfv98vnhn.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> There is a big number of cpuidle drivers for the ARM architecture.
>
> These drivers have been cleaned up and grouped into the drivers/cpuidle
> directory to keep track of the changes more easily and ensure the code
> is following the same scheme across the drivers.
>
> That had the benefit of simplifying the code and factor out a lot of common
> parts. Beside that, as the drivers belong to the 'drivers' directory, we had
> to split the arch specific bits and the generic code in order to keep
> everything self contained. The platform driver paradigm was used for this
> purpose.
>
> Unfortunately, this approach is now no longer accepted and a different solution
> must be provided to reach the same goal: one example is the Qualcomm cpuidle
> driver upstreaming attempt [1].
>
> In the meantime, ARM64 developed a generic cpuidle driver based on DT definition.
>
> The DT definition provides an 'enable-method' to specify one of the cpu
> operations (PSCI, ...).
>
> This patchset unify this driver with ARM32, using the same DT definition.
>
> Thanks with this patchset we can use the 'enable-method' to specify a cpu
> operations, hence get rid of the platform driver approach and go further in the
> cpuidle driver flexibility via the DT.

I really like that these two are unified now.

Acked-by: Kevin Hilman <khilman@linaro.org>
