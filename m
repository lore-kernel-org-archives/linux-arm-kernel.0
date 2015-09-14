From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 14 Sep 2015 13:47:14 +0100
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <55F6B8CC.5090406@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <55F68BC9.6020509@citrix.com> <55F6A437.3040403@citrix.com>
 <55F6A9DB.8040503@citrix.com> <55F6ADAE.1010609@citrix.com>
 <55F6B8CC.5090406@citrix.com>
Message-ID: <55F6C1D2.7010206@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/15 13:08, Roger Pau Monn? wrote:
>> I'd like to see a basic support of 64KB page granularity upstream before
>> starting to think about performance improvement. And there is still a
>> lot to do.
> 
> I wasn't actually thinking of this as a performance improvement, but
> rather as a way of fixing this properly and removing the complexity
> added to xen-blkfront, thus providing a PV block protocol that natively
> supports 64KB pages. This would be like hardware components already do
> AFAIK, because I don't think there are other drivers in the Linux tree
> that do this kind of splitting.
> 
>> Although, having 64KB grants won't remove the splitting as we would
>> still have to support frontend/backend which only handle 4KB grant.
> 
> IMHO, given enough time I would just drop those.

The PV protocol has always been backward compatible.

Introducing the support of 64KB grant will require some changes in Xen
which won't surely be backported to older version. We still have to be
able to run new Linux guest on older Xen and vice versa.

To give you an example, Centos 7, which will support Xen and only 64KB
page granularity, will be supported for years. Dropping any splitting in
a short future (3-5 years) will just break those guests to boot on Xen.

AFAIK, we never took a such radical decision on Xen based on the
complexity of the code.

Regards,

-- 
Julien Grall
