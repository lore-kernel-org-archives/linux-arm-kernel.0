From: J.Lambrecht@TELEVIC.com (=?iso-8859-1?Q?Lambrecht_J=FCrgen?=)
Date: Fri, 17 Jun 2011 14:13:04 +0200
Subject: unsigned int 'return -1' in /sound/soc/codecs/tlv320aic23.c
Message-ID: <4DFB44D0.4080306@televic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I see this error in /sound/soc/codecs/tlv320aic23.c:

static inline unsigned int tlv320aic23_read_reg_cache(struct snd_soc_codec
               ^^^^^^^^
                               *codec, unsigned int reg)
{
     u16 *cache = codec->reg_cache;
     if (reg >= ARRAY_SIZE(tlv320aic23_reg))
         return -1;
                ^^
     return cache[reg];
}

Maybe better return 0?
Best read the codec datasheet to find a safe or non-existing value?
And also a "printk(KERN_ERR " then?
Actually, better just remove the check, because if you want to write a 
codec register, you must know what you are doing?

I am busy with the codec driver for mc13783.
Currently, the mc13783 (from Sascha Hauer) code does not check 'reg'.

(I want to supply a patch finally, but as newbie: from which GIT?, 
because mine is a merge of 2 branches of the Pengutronix GIT)

Regards,
J?rgen

-- 
J?rgen Lambrecht
R&D Associate
Tel: +32 (0)51 303045    Fax: +32 (0)51 310670
http://www.televic-rail.com
Televic Rail NV - Leo Bekaertlaan 1 - 8870 Izegem - Belgium
Company number 0825.539.581 - RPR Kortrijk
