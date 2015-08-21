From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Aug 2015 18:32:42 +0100
Subject: Prevent list poison values from being mapped by userspace
 processes
In-Reply-To: <20150821133043.GV7557@n2100.arm.linux.org.uk>
References: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
 <20150821133043.GV7557@n2100.arm.linux.org.uk>
Message-ID: <20150821173242.GD16410@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 02:30:43PM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 18, 2015 at 02:42:44PM -0700, Jeffrey Vander Stoep wrote:
> > List poison pointer values point to memory that is mappable by
> > userspace. i.e. LIST_POISON1 = 0x00100100 and LIST_POISON2 =
> > 0x00200200. This means poison values can be valid pointers controlled
> > by userspace and can be used to exploit the kernel as demonstrated in
> > a recent blackhat talk:
> > https://www.blackhat.com/docs/us-15/materials/us-15-Xu-Ah-Universal-Android-Rooting-Is-Back-wp.pdf
> > 
> > Can these poison values be moved to an area not mappable by userspace
> > on 32 bit ARM?
> 
> As was discussed privately before your message, both Catalin and myself
> agreed that this is not possible, and I proposed alternatives which were
> feasible.

Nice to see these patches so quickly. However, I'll be away for the next
~12 days, so I won't be able to review them.

-- 
Catalin
