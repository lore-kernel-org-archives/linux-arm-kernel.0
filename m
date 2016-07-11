From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 11 Jul 2016 12:27:01 +0000
Subject: sh-eth.c writes to non-existent register on RZ/A1
In-Reply-To: <CAFr9PXniO=qPUpok1dVHzjrEpKVo6t3koc2n=UCjWrdD_DL+5A@mail.gmail.com>
References: <CAFr9PXniO=qPUpok1dVHzjrEpKVo6t3koc2n=UCjWrdD_DL+5A@mail.gmail.com>
Message-ID: <KL1PR06MB1749BFFCB144EE55402339968A3F0@KL1PR06MB1749.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

You might have better luck posting Renesas device questions to the Renesas mailing list.

http://vger.kernel.org/vger-lists.html#linux-renesas-soc




> There seem to be a few different controllers that are roughly the same and used in Renesas...

Yes, that base Ethernet IP block has been used in many SH4 and Renesas-ARM devices over the years and has many variations. Makes it easy for code reuse.


> The controller in the RZ/A1 has a tsu but is missing one of the registers that is
> called "TSU_POST1" in the tables for other chips.

That is because this feature (POST) is dealing with relaying frames between two Ethernet ports, and as you know...the RZ/A1 only has 1 Ethernet controller. So it makes sense that this register isn't included.


> and I considered submitting a patch with the contents of sh_eth_tsu_enable_cam_entry_post() wrapped with if(sh_eth_is...)

It's on my list of things to do in the next couple months to push in all the RZ/A1 BSP driver changes back upstream. After I got the XIP_LINUX fixes in earlier this year, I got a bit side tracked on other projects.


Chris
