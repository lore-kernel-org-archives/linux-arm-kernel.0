From: labbott@redhat.com (Laura Abbott)
Date: Fri, 3 Mar 2017 11:10:55 -0800
Subject: [RFC PATCH 11/12] staging: android: ion: Make Ion heaps selectable
In-Reply-To: <20170303103304.nxfn7zlccx24b3xq@phenom.ffwll.local>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <1488491084-17252-12-git-send-email-labbott@redhat.com>
 <20170303103304.nxfn7zlccx24b3xq@phenom.ffwll.local>
Message-ID: <2b0c35ce-be88-526c-e0ab-1707c191260d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2017 02:33 AM, Daniel Vetter wrote:
> On Thu, Mar 02, 2017 at 01:44:43PM -0800, Laura Abbott wrote:
>>
>> Currently, all heaps are compiled in all the time. In switching to
>> a better platform model, let's allow these to be compiled out for good
>> measure.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
> 
> I'm not the biggest fan of making everything Kconfig-selectable. And the
> #ifdef stuff doesn't look all that pretty. If we'd also use this
> opportunity to split each heap into their own file I think this patch here
> would be a lot more useful.
> 
> Anyway, no real opinion from me on this, just an idea.
> -Daniel
> 

My idea with the Kconfigs was that if platforms didn't want certain
heap types (e.g. chunk heap) they could just be turned off.
I do want to fully fix up the initialization better as well.

Thanks,
Laura
