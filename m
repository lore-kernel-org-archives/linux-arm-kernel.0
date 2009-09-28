From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Mon, 28 Sep 2009 11:20:57 +0200
Subject: Problem with mxc_nand driver
In-Reply-To: <a57e67db0909280156x686f0d26u397dc6397fd0b3a@mail.gmail.com>
References: <a57e67db0909272341k59d4cda6pde85ff7425a75c8f@mail.gmail.com>	<4AC0682D.6000907@eukrea.com>
	<a57e67db0909280156x686f0d26u397dc6397fd0b3a@mail.gmail.com>
Message-ID: <4AC07FF9.2040002@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jernej Turnsek a ?crit :
> are you using HW ECC on your chip? I suspect that HW ECC is writting
> something into space provided for the clean markers. I will
> investigate to.
> 
yes, I'm using HW ECC.
static struct mxc_nand_platform_data eukrea_cpuimx27_nand_board_info = {
	.width = 1,
	.hw_ecc = 1,
};

In fact, maybe the change to the NAND driver should test hw_ecc as it 
shouldn't be necessary for software ecc.

Eric
