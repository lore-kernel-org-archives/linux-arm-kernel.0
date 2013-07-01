From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon,  1 Jul 2013 10:39:38 +0200
Subject: [RFC PATCH 13/13] sound: codec: wm8371: correct capture line/mic
In-Reply-To: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1372667978-4718-14-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the "switch" text, we can't enable the line and mic capture in
alsamixer.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 sound/soc/codecs/wm8731.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 3cf6b20..dae1403 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -164,10 +164,10 @@ SOC_DOUBLE_R("Master Playback ZC Switch", WM8731_LOUT1V, WM8731_ROUT1V,
 
 SOC_DOUBLE_R_TLV("Capture Volume", WM8731_LINVOL, WM8731_RINVOL, 0, 31, 0,
 		 in_tlv),
-SOC_DOUBLE_R("Line Capture Switch", WM8731_LINVOL, WM8731_RINVOL, 7, 1, 1),
+SOC_DOUBLE_R("Line Capture", WM8731_LINVOL, WM8731_RINVOL, 7, 1, 1),
 
 SOC_SINGLE_TLV("Mic Boost Volume", WM8731_APANA, 0, 1, 0, mic_tlv),
-SOC_SINGLE("Mic Capture Switch", WM8731_APANA, 1, 1, 1),
+SOC_SINGLE("Mic Capture", WM8731_APANA, 1, 1, 1),
 
 SOC_SINGLE_TLV("Sidetone Playback Volume", WM8731_APANA, 6, 3, 1,
 	       sidetone_tlv),
-- 
1.7.10.4
