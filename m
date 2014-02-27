From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Feb 2014 15:09:28 +0100
Subject: [PATCH v2 1/3] Fix ioport_map() for !CONFIG_GENERIC_IOMAP cases.
In-Reply-To: <1393506599-11561-2-git-send-email-Liviu.Dudau@arm.com>
References: <1393506599-11561-1-git-send-email-Liviu.Dudau@arm.com>
 <1393506599-11561-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <5331963.VjH27eqhpK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 13:09:57 Liviu Dudau wrote:
> The inline version of ioport_map() that gets used when !CONFIG_GENERIC_IOMAP
> is wrong. It returns a mapped (i.e. virtual) address that can start from
> zero and completely ignores the PCI_IOBASE and IO_SPACE_LIMIT that most
> architectures that use !CONFIG_GENERIC_MAP define.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
