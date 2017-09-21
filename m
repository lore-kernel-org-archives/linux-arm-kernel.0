From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 21 Sep 2017 15:45:28 +0800
Subject: [PATCH] tee: ACPI support for optee driver
In-Reply-To: <1505977937-25034-1-git-send-email-mchitale@apm.com>
References: <1505977937-25034-1-git-send-email-mchitale@apm.com>
Message-ID: <59C36E18.1050106@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/9/21 15:12, Mayuresh Chitale wrote:
> This patch modifies the optee driver to add support for parsing
> the conduit method from an ACPI node.

Sorry I didn't involve this earlier, but I think this is a wrong
approach, in ACPI 5.1+ spec, there is a bit in FADT table which
indicates PSCI using SMC or HVC, please see ACPI 6.2 [1],
Table 5-37 Fixed ACPI Description Table ARM Boot Architecture Flags.

Can we just use that to get the conduit method for optee driver too?

[1]: http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf

Thanks
Hanjun
