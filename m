From: timyao@gmail.com (Tim Yao)
Date: Thu, 3 Jun 2010 16:22:02 -0700
Subject: Question about flush_dcache_all in kernel start up code
Message-ID: <AANLkTimWFpNC_tXJB84pzVrg14Ot_Nk7WGVE9Qwvg_pK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I have a question regarding the data cache flush routine called at the
beginning of kernel start up. At the beginning of the start up code, after
processor type and machine type look up and simple page table created, a
__switch_data is called which goes to __v7_setup in my case (since the CPU
is A9). Then at the beginning of the function it calls v7_flush_dcache_all.
This cache routine is in cache-v7.S and I see it actually does "clean and
invalidate" operation as opposed to invalidate only.
