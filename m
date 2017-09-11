From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Sep 2017 13:35:02 +0530
Subject: [PATCH] davinci: Add cpufreq support when booting with device tree
In-Reply-To: <1504958709-23357-1-git-send-email-aford173@gmail.com>
References: <1504958709-23357-1-git-send-email-aford173@gmail.com>
Message-ID: <8f8633af-75a2-674f-9301-3876d72e84d9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

On Saturday 09 September 2017 05:35 PM, Adam Ford wrote:
> While cpufreq itself doesn't appear to directly support the
> device tree, we can register it inside da850_init_machine
> when we register other devices.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

There is an OPP-based, DT-enabled cpufreq driver available. Please see
support in drivers/cpufreq/cpufreq-dt-platdev.c

We should use that instead of this platform specific hack.

Looking at Documentation/devicetree/bindings/opp/opp.txt, it seems like
we should use the v2 bindings from the start. They do have useful
features like disabling certain OPPs on certain parts depending on the
parametrics[1]

Thanks,
Sekhar

[1] http://www.ti.com/product/AM1808#parametrics
