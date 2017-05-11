From: jk@ozlabs.org (Jeremy Kerr)
Date: Thu, 11 May 2017 09:58:16 +0800
Subject: [PATCH v6 19/23] drivers/fsi: Add GPIO based FSI master
In-Reply-To: <c05599db-7767-e712-7199-7d5a4ac6486f@linux.vnet.ibm.com>
References: <20170410194706.64280-1-cbostic@linux.vnet.ibm.com>
 <20170410194706.64280-20-cbostic@linux.vnet.ibm.com>
 <CACPK8Xf1Y31+HBHb0ErpnZ4xVM+bzfHV-khj-kz8Unk1cTx6gw@mail.gmail.com>
 <c05599db-7767-e712-7199-7d5a4ac6486f@linux.vnet.ibm.com>
Message-ID: <a079022b-8434-a204-c9b4-696a0580fc8c@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

> I don't think we'd want this per master.   The lock is for the 'top'
> master issuing commands.  Only the top master can initiate any
> transactions on the bus to any devices connected downstream. Downstream
> masters such as hub masters, etc... cannot initiate a command.

I think what Joel meant there was that we have it per *GPIO* master; if
there are two GPIO masters on a system, there's no need to provide
mutual exclusion to each (separate) set of GPIOs.

To implement this, we'd just move the lock into struct fsi_master_gpio.

Cheers,


Jeremy
