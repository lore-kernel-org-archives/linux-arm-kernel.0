From: mingo@elte.hu (Ingo Molnar)
Date: Mon, 20 Jun 2011 09:41:24 +0200
Subject: [PATCH 00/10] Enhance /dev/mem to allow read/write of arbitrary
	physical addresses
In-Reply-To: <4DFE89E0.5020509@zytor.com>
References: <201106171038.25988.ptesarik@suse.cz>
	<20110617093032.GA19235@elte.hu> <4DFE7FF9.9070406@gmail.com>
	<4DFE89E0.5020509@zytor.com>
Message-ID: <20110620074124.GB24716@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> There are some test drivers which really want /dev/mem to work.

Test drivers and test hardware with zero enumeration can use below 4G 
addresses just fine.

Also, debugging is not an issue and some non-default kernel or boot 
option can enable any sort of device i guess, so my main worry isnt 
really security but that we should stand in the way of the apparent 
practice of *shipping* user-space drivers that use /dev/mem ...

Thanks,

	Ingo
