From: randy.dunlap@oracle.com (Randy Dunlap)
Date: Thu, 01 Jul 2010 14:48:29 -0700
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <alpine.DEB.2.00.1007011450130.13691@utopia.booyaka.com>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
	<alpine.DEB.2.00.1007011450130.13691@utopia.booyaka.com>
Message-ID: <4C2D0D2D.8090407@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/10 13:59, Paul Walmsley wrote:
> Randy,
> 
> On Thu, 1 Jul 2010, Randy Dunlap wrote:
> 
>>> + * @start_addr	The starting address of the VCM region.
>>> + * @len 	The len of the VCM region. This must be at least
>>> + *		vcm_min() bytes.
>>
>> and missing lots of struct members here.
>> If some of them are private, you can use:
>>
>> 	/* private: */
>> ...
>> 	/* public: */
>> comments in the struct below and then don't add the private ones to the
>> kernel-doc notation above.
> 
> To avoid wasting space in structures, it makes sense to place fields 
> smaller than the alignment width together in the structure definition.  
> If one were to do this and follow your proposal, some structures may need 
> multiple "private" and "public" comments, which seems undesirable.  The 
> alternative, wasting memory, also seems undesirable.  Perhaps you might 
> have a proposal for a way to resolve this?

I don't know of a really good way.  There are a few structs that have
multiple private/public entries, and that is OK.
Or you can describe all of the entries with kernel-doc notation.
Or you can choose not to use kernel-doc notation on some structs.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
