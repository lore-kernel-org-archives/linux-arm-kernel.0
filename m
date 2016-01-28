From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 28 Jan 2016 16:11:44 +0300
Subject: [PATCH] ipv4: ipconfig: avoid unused ic_proto_used symbol
In-Reply-To: <1453902853-3424272-1-git-send-email-arnd@arndb.de>
References: <1453902853-3424272-1-git-send-email-arnd@arndb.de>
Message-ID: <56AA1390.6000503@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/27/2016 4:53 PM, Arnd Bergmann wrote:

> When CONFIG_PROC_FS, CONFIG_IP_PNP_BOOTP, CONFIG_IP_PNP_DHCP and
> CONFIG_IP_PNP_RARP are all disabled, we get a warning about the
> ic_proto_used variable being unused:
>
> net/ipv4/ipconfig.c:146:12: error: 'ic_proto_used' defined but not used [-Werror=unused-variable]
>
> This avoids the warning, but making the definition conditional on

    s/but/by/?

> whether a dynamic IP configuration protocol is configured. If not,
> we know that the value is always zero, so we can optimize away the
> variable and all code that depends on it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[...]

MBR, Sergei
