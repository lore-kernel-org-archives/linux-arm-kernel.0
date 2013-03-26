From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 21:44:44 +0000
Subject: [PATCH v2 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <76d3fea8e633c122a4bc8bded96814a085a2f239.1364319776.git.michal.simek@xilinx.com>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <76d3fea8e633c122a4bc8bded96814a085a2f239.1364319776.git.michal.simek@xilinx.com>
Message-ID: <201303262144.45158.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Michal Simek wrote:
> +void __iomem *scu_base;
> +

This cannot be a global variable in a multiplatform kernel. Can you
make it static?

	Arnd
