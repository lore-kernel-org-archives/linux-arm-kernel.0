From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 1 Apr 2013 17:09:24 +0000 (UTC)
Subject: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
In-Reply-To: <CAOmKuSpbaKutLxbNihBRDz+B0Wt0XiPss-PcEHc-efCTvciNFg@mail.gmail.com>
References: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com>
 <CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com>
 <alpine.DEB.2.00.1304010844100.28273@utopia.booyaka.com>
 <CAOmKuSrABrPcZ=Yg1+LAHWbh9CdTYR0eUmJ2dd3z91oz0uu21g@mail.gmail.com>
 <alpine.DEB.2.00.1304011008230.28273@utopia.booyaka.com>
 <CAOmKuSrbDc025Tj9xsqDebJ_KZdp_VnWAOs_OO5UAegV43JcDQ@mail.gmail.com>
 <CAOmKuSpbaKutLxbNihBRDz+B0Wt0XiPss-PcEHc-efCTvciNFg@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1304011654520.9148@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Apr 2013, Alexey Pelykh wrote:

> Please, correct me if I'm wrong, you're experiencing issues on Tx, or
> Rx direction? You've said that characters are echoed incorrectly, but
> haven't mentioned in what direction issue appears?

The problem seems to be on the Rx path.  If I 'cat' a file, it's 
transmitted without hesitation.  But when I paste in this Simpsons quote 
into the serial console via X:

-----
Mr. Burns: A lifetime of working with nuclear power has left me with a healthy green glow... and left me as impotent as a Nevada boxing commissioner. 
-----

... everything up to the end of "boxing" is echoed immediately, and then 
"commissioner." stutters its way across the screen over the next five 
seconds.  


- Paul
