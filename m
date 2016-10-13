From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 13 Oct 2016 19:18:37 +0100
Subject: [PATCH v2] perf: xgene: Remove bogus IS_ERR() check
In-Reply-To: <1476382156-11641-1-git-send-email-ttnguyen@apm.com>
References: <1476382156-11641-1-git-send-email-ttnguyen@apm.com>
Message-ID: <20161013181837.GQ19539@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2016 at 11:09:16AM -0700, Tai Nguyen wrote:
> In acpi_get_pmu_hw_inf we pass the address of a local variable to IS_ERR(),
> which doesn't make sense, as the pointer must be a real, valid pointer.
> This doesn't cause a functional problem, as IS_ERR() will evaluate as
> false, but the check is bogus and causes static checkers to complain.

... unless the test is actually a misspelled IS_ERR(res) and the current
code is broken by effectively skipping it.
