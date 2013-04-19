From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Apr 2013 18:14:56 +0100
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <CAFEAcA_vdXbtK=U2gauC=DsrB=_cSfcUTaNCiB0Ts4YOq_pXEg@mail.gmail.com>
References: <CAAHg+HipCX2ma6brxj9Kgc3ew39b5e30grLwyun9CViif-5wZQ@mail.gmail.com>
 <20130419092752.GB13283@mudshark.cambridge.arm.com>
 <CAFEAcA8j124G=vaHObJ_w5wOhUiS3KYKbjMnigbnr6mgwFxZUg@mail.gmail.com>
 <CAAHg+Hg=t97SJ0JPZYgrZaL+zimo-wbezwaj1BQvHqE-vf4VDA@mail.gmail.com>
 <20130419093953.GD13283@mudshark.cambridge.arm.com>
 <CAFEAcA_WfYpyvq54rZqS8JZkmDF5JXB+CNHFH5CnrhKun52uzA@mail.gmail.com>
 <20130419161201.GA5383@localhost.cambridge.arm.com>
 <CAFEAcA-F18kR4JihdxaLTm3qb4n51tsygG1RW4djwJ0u9+FQqw@mail.gmail.com>
 <20130419162226.GB5383@localhost.cambridge.arm.com>
 <CAFEAcA_vdXbtK=U2gauC=DsrB=_cSfcUTaNCiB0Ts4YOq_pXEg@mail.gmail.com>
Message-ID: <20130419171455.GA43450@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 05:33:18PM +0100, Peter Maydell wrote:
> On 19 April 2013 17:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > earlyprintk is used for debugging early problems, like DT parsing. You
> > don't have to use it unless you are debugging something. Without
> > earlyprintk you just get a normal console during boot, based on the DT
> > description.
> 
> The command line lives in the DTB anyway so if you can't look
> in the DTB you can't get at earlyprintk config either way.

Linux indeed looks in the DT for the command line and that's what's
triggering the earlyprintk console but at that stage the DT is flat.
Unflattening the DT happens later (it requires slab allocator). I
initially thought about extracting the early console device from the DT
but when it is flat you can't parse the full hierarchy to get its
address.

-- 
Catalin
