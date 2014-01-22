From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 23:52:04 +0000
Subject: [PATCH v3 22/24] drm/i2c: tda998x: change the frequence in the
 audio channel
In-Reply-To: <20140119195847.646a40b0@armhf>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195847.646a40b0@armhf>
Message-ID: <20140122235204.GS15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:58:47PM +0100, Jean-Francois Moine wrote:
> This patch sets the frequence as 'not indicated' instead of '48kHz'
> and adds some comments.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Good catch that byte 2 doesn't exist in this set.

sound/asounddef.h has definitions for these:

IEC958_AES0_CON_NOT_COPYRIGHT
IEC958_AES3_CON_FS_NOTID
IEC958_AES4_CON_MAX_WORDLEN_24
IEC958_AES4_CON_ORIGFS_NOTID

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
