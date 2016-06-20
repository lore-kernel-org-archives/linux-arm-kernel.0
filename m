From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 20 Jun 2016 17:07:34 -0400
Subject: [PATCH 1/4] MAINTAINERS: Fix nsp false-positives
In-Reply-To: <1466456857-11969-1-git-send-email-jon.mason@broadcom.com>
References: <1466456857-11969-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1466456857-11969-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'nsp' regex pattern in the "BROADCOM IPROC ARM ARCHITECTURE" section
is getting unintended hits due to the common frequence of these letters
appearing in sequence.  To change the regex expression to be more
specific to the files we care about, add a "bcm" prefix to the regex and
add file entries for those that do not naturally match this new regex.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7304d2e..18b235a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2601,7 +2601,7 @@ T:	git git://github.com/broadcom/cygnus-linux.git
 S:	Maintained
 N:	iproc
 N:	cygnus
-N:	nsp
+N:	bcm[-_]nsp
 N:	bcm9113*
 N:	bcm9583*
 N:	bcm9585*
@@ -2612,6 +2612,8 @@ N:	bcm583*
 N:	bcm585*
 N:	bcm586*
 N:	bcm88312
+F:	drivers/clk/bcm/clk-ns*
+F:	drivers/pinctrl/bcm/pinctrl-ns*
 
 BROADCOM BRCMSTB GPIO DRIVER
 M:	Gregory Fong <gregory.0xf0@gmail.com>
-- 
1.9.1
