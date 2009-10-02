From: Peiyu.Li@csr.com (Peiyu Li)
Date: Thu, 1 Oct 2009 18:27:56 -0700
Subject: how to keep some basic relocation information in executable binary
Message-ID: <ED2979D1CA1B3E4BB166ED9990088522366040@SJOAMSEXB01.AMERICAS.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

I am trying to find a way to build out one ARM-instruction binary that
can run at any address in the bare metal environment. The GOT can
relocate most of the symbols. But for those pointers which have been
static initialized in struct, I have not found a good way to fix them at
run-time. As you know, there may be pointers or non-pointers data in the
struct. To only fix the pointer data, I must know the detail relocation
information at run-time. 
It seems that -emit-relocs option is designed for runtime relocation,
and it can keep the relocation information in the final elf format
executable file. After convert this elf format to the binary format by
using "objcopy" tool, the relocation information is lost. I still can
not know which data need to be relocated in the static initialized
struct.

How can I know the relocation information for these static initialized
struct? Besides that pointers in GOT and the static initialized struct ,
is there any other data should be run-time relocated in the binary
executable file?
Any help would be greatly appreciated.
Thanks in advance.
Peiyu 1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
