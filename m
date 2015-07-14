From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 14 Jul 2015 17:37:08 +0200
Subject: [PATCH v2 19/20] xen/privcmd: Add support for Linux 64KB page
 granularity
In-Reply-To: <55A52A9E.2000400@oracle.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-20-git-send-email-julien.grall@citrix.com>
 <55A41BE4.3080104@oracle.com> <55A43638.4030503@citrix.com>
 <55A52A9E.2000400@oracle.com>
Message-ID: <55A52CA4.1040107@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 14/07/2015 17:28, Boris Ostrovsky wrote:
> On 07/13/2015 06:05 PM, Julien Grall wrote:
>> On 13/07/2015 22:13, Boris Ostrovsky wrote:
>>> On 07/09/2015 04:42 PM, Julien Grall wrote:
>>>> -
>>>>   struct remap_data {
>>>>       xen_pfn_t *fgmfn; /* foreign domain's gmfn */
>>>> +    xen_pfn_t *efgmfn; /* pointer to the end of the fgmfn array */
>>>
>>> It might be better to keep size of fgmfn array instead.
>>
>> It would means to have an other variable to check that we are at the
>> end the array.
>
>
> I thought that's what h_iter is. Is it not?

h_iter is for the number of xen pfn in a Linux page. This is because the 
Linux privcmd interface is working with 4KB page and there may not be 
enough to fill a 64KB page.

So we need another counter for the total number of foreign domain's gmfn.

Regards,

-- 
Julien Grall
