From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 29 Oct 2014 13:44:24 -0700
Subject: [PATCH 1/4] PM / Domains: Remove reference counting for the
 generic_pm_domain_data
In-Reply-To: <1414507090-516-2-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Tue, 28 Oct 2014 15:38:07 +0100")
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
 <1414507090-516-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7hk33i7gif.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> The reference counting isn't needed, let's remove it.

After reading the commit that added this feature[1], I think this
changelog needs a more detail explaining why it's not needed anymore.

Kevin

[1]
commit 1d5fcfec22ce5f69db0d29284d2b65ff8ab1bfaa
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Thu Jul 5 22:12:32 2012 +0200

    PM / Domains: Add device domain data reference counter

    Add a mechanism for counting references to the
    struct generic_pm_domain_data object pointed to by
    dev->power.subsys_data->domain_data if the device in question
    belongs to a generic PM domain.

    This change is necessary for a subsequent patch making it possible to
    allocate that object from within pm_genpd_add_callbacks(), so that
    drivers can attach their PM domain device callbacks to devices before
    those devices are added to PM domains.

    This patch has been tested on the SH7372 Mackerel board.

    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
