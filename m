From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Thu, 11 Sep 2014 14:11:05 +0000
Subject: [PATCH v10 07/10] OF: Introduce helper function for getting PCI
 domain_nr
In-Reply-To: <2908259.jgJNuDxCCa@wuerfel>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <3780051.0eHpCN6UC9@wuerfel> <20140909112054.GD29639@arm.com>
 <2908259.jgJNuDxCCa@wuerfel>
Message-ID: <ae98d68652f1495a857f081c3a6aecb2@HKXPR06MB168.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10 September 2014 19:20, Arnd wrote:
> On Tuesday 09 September 2014 12:20:54 Catalin Marinas wrote:
> >
> > We can assume that if a domain is not specified and there is a single
> > top level PCIe node, the domain defaults to 0. Are there any arm32
> > platforms that require multiple domains (and do not specify a number in
> > the DT)?
> 
> In theory, I think all of them could work with a single domain, but then
> you need to partition the bus number space between the host controllers,
> so you have the exact same situation that you either need to make up
> random bus numbers or put them in DT.
> 
> Using multiple domains is way cleaner for this, even if we have to
> make up the numbers.

Maybe this is a stupid question, but why would you want to specify the domain
in the DT at all? Doesn't every instance of a driver imply a separate domain?

Thanks
Phil 
