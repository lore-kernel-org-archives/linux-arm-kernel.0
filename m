From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  3 Feb 2017 17:46:25 +0100
Subject: [PATCH] ARM: defconfigs: make NF_CT_PROTO_SCTP and
 NF_CT_PROTO_UDPLITE built-in
Message-ID: <20170203164647.3610978-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbols can no longer be used as loadable modules, leading to a harmless Kconfig
warning:

arch/arm/configs/imote2_defconfig:60:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
arch/arm/configs/imote2_defconfig:59:warning: symbol value 'm' invalid for NF_CT_PROTO_SCTP
arch/arm/configs/ezx_defconfig:68:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
arch/arm/configs/ezx_defconfig:67:warning: symbol value 'm' invalid for NF_CT_PROTO_SCTP

Let's make them built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/ezx_defconfig    | 4 ++--
 arch/arm/configs/imote2_defconfig | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index ea316c4b890e..d3f1768840e2 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -64,8 +64,8 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_SCTP=m
-CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CT_PROTO_SCTP=y
+CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/arm/configs/imote2_defconfig b/arch/arm/configs/imote2_defconfig
index 18e59feaa307..7f479cdb3479 100644
--- a/arch/arm/configs/imote2_defconfig
+++ b/arch/arm/configs/imote2_defconfig
@@ -56,8 +56,8 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_SCTP=m
-CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CT_PROTO_SCTP=y
+CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
-- 
2.9.0
