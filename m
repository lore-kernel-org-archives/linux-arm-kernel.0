From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Mon, 21 Sep 2009 10:06:42 +0300
Subject: [PATCH 1/2] ARM: Pass IFSR register to do_PrefetchAbort()
In-Reply-To: <20090920122411.GA5413@n2100.arm.linux.org.uk>
References: <c9f73fa56a41bc1051cd347cc453081235e3d776.1253307263.git.kirill@shutemov.name>
	<20090919110316.GA23452@n2100.arm.linux.org.uk>
	<20090920081550.GA830@n2100.arm.linux.org.uk>
	<cc557aab0909200235sbb4c1f5tdc84434732222988@mail.gmail.com>
	<20090920122411.GA5413@n2100.arm.linux.org.uk>
Message-ID: <cc557aab0909210006n2f423bf9lf208e355bed0fada@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 20, 2009 at 3:24 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Sep 20, 2009 at 12:35:19PM +0300, Kirill A. Shutemov wrote:
>> Ok, so __do_page_fault() should know where we are: in data abort or in
>> prefetch abort. What is right way to do it? Should we create one more
>> argument or use one of reserved bits IFSR?
>
> Well, this is my solution to the problem - could you test it please?

Yes, it works. But I still think that ignoring IFSR is a mistake. I'll send
updated patches
