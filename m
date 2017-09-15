From: pasha.tatashin@oracle.com (Pavel Tatashin)
Date: Thu, 14 Sep 2017 21:30:28 -0400
Subject: [PATCH v8 10/11] arm64/kasan: explicitly zero kasan shadow memory
In-Reply-To: <20170915011035.GA6936@remoulade>
References: <20170914223517.8242-1-pasha.tatashin@oracle.com>
 <20170914223517.8242-11-pasha.tatashin@oracle.com>
 <20170915011035.GA6936@remoulade>
Message-ID: <c76f72fc-21ed-62d0-014e-8509c0374f96@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thank you for looking at this. We can't do this because page table is 
not set until cpu_replace_ttbr1() is called. So, we can't do memset() on 
this memory until then.

Pasha
