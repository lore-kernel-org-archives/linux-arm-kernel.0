From: p.pisati@gmail.com (Paolo Pisati)
Date: Fri, 22 Jun 2012 13:51:42 +0200
Subject: MMC: commit dba3c29 ruins mmc card data on beagle-xm revB
In-Reply-To: <CANrkHUawrQfb+o+W7FrYACv6NocZn_MAym5A209peP8tW1nZRQ@mail.gmail.com>
References: <CACVXFVO-Wm1Qwporby1M=+yPz81AWHpZRBZSbr5tgT32b6sSEA@mail.gmail.com>
 <CANrkHUYd8Ww6De4MiZ8_oPfcnhvtsZXOySLRiWSBU4QUQ6beHw@mail.gmail.com>
 <CACVXFVP16UmHe-GGydrSMgGHwnkSvYhnY339=zr=BfCehvS8Kw@mail.gmail.com>
 <CANrkHUaxJGcv2bdUWTCB_oKct-iFCKCdb7OQPTUjS4MuKeCS2w@mail.gmail.com>
 <4FE0AE7B.4040502@gmail.com>
 <CANrkHUawrQfb+o+W7FrYACv6NocZn_MAym5A209peP8tW1nZRQ@mail.gmail.com>
Message-ID: <4FE45C4E.8060808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2012 09:23 AM, T Krishnamoorthy, Balaji wrote:
>>
>> i just want to say that i'm affected by this too, and i can reproduce it
>> 100%.
>>
> 
> Is it with SD or MMC card
> Can you provide Beagle board rev info?

kingston 4g class 4 sdhc c04g taiwan

tested on a beagle xm rev a and rev c, both boards exhibit the same
problem with this card, while with a brand new sandisk 16gb sdhc class 4
card, everything is ok.

i tried reverting dba3c29 "Enable Auto CMD12", and both cards are
behaving fine.

>> do you want me to run that patch or you already have enough data?
> 
> Can you enable MMC debug and apply the debug patch I provided.
> The debug patch did not print any AUTOCMD errors with Ming Lei setup.

http://people.canonical.com/~ppisati/mmc-testing/

test-mmc.sh: script used for testing

test-mmc.log: md5sum of file copied around (as you can see after the
umount the md5 changes)

test-mmc.syslog: mmc-debug output (plus your patch)

after the test, my sd card was so badly wounded that it wouldn't even boot.
-- 
bye,
p.
