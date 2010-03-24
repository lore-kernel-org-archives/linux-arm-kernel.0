From: mroberto@cpti.cetuc.puc-rio.br (Marcelo Roberto Jimenez)
Date: Wed, 24 Mar 2010 20:04:57 -0300
Subject: [PATCH 1/2] ARM: pcmcia: Fix for building DEBUG with sa11xx_base.c as
	a module.
Message-ID: <1269471898-26301-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a compilation issue when compiling PCMCIA SA1100
support as a module with PCMCIA_DEBUG enabled. The symbol
soc_pcmcia_debug was not beeing exported.

Signed-off-by: Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
---
 drivers/pcmcia/soc_common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 6f1a86b..fd4c25a 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -65,6 +65,7 @@ void soc_pcmcia_debug(struct soc_pcmcia_socket *skt, const char *func,
 		va_end(args);
 	}
 }
+EXPORT_SYMBOL(soc_pcmcia_debug);
 
 #endif
 
-- 
1.7.0.3
