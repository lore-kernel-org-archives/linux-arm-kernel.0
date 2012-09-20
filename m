From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Sep 2012 22:07:55 +0100
Subject: [PATCH 1/4] ARM: mm: use pteval_t to represent page protection
 values
In-Reply-To: <alpine.LFD.2.02.1209201422230.6667@xanadu.home>
References: <1348156605-30398-1-git-send-email-will.deacon@arm.com>
 <1348156605-30398-2-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1209201422230.6667@xanadu.home>
Message-ID: <20120920210754.GA22307@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Thu, Sep 20, 2012 at 07:28:14PM +0100, Nicolas Pitre wrote:
> On Thu, 20 Sep 2012, Will Deacon wrote:
> 
> > When updating the page protection map after calculating the user_pgprot
> > value, the base protection map is temporarily stored in an unsigned long
> > type, causing truncation of the protection bits when LPAE is enabled.
> > This effectively means that calls to mprotect() will corrupt the upper
> > page attributes, clearing the XN bit unconditionally.
> > 
> > This patch uses pteval_t to store the intermediate protection values,
> > preserving the upper bits for 64-bit descriptors.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Thanks.

> Maybe CC to stable?

Of course.

> Are you sure there are no other occurences of this elsewhere?  
> Unfortunately, STRICT_MM_TYPECHECKS can't help here.

I grepped for lines containing `pgprot' and `long' and didn't find any
other problematic code. Everything else seems to use the pgprot_t types
consistently.

Will
