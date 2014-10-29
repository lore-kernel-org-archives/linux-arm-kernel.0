From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 29 Oct 2014 15:28:16 -0700
Subject: [PATCH 2/4] PM / Domains: Don't allow an existing generic PM
 domain data
In-Reply-To: <1414507090-516-3-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Tue, 28 Oct 2014 15:38:08 +0100")
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
 <1414507090-516-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7hegtq5x4v.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> While adding devices to the generic PM domain we allocate data for the
> struct generic_pm_domain_data.
>
> Don't allow existing generic_pm_domain_data in this case, since that
> indicates the device is already being added from another context. Let's
> instead return an error.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Similar to PATCH 1/4, it would be good to summarize/remind why this
feature was added in the first place, and why it's not longer needed.

Kevin
