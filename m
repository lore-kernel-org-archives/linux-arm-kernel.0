From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Tue, 06 May 2014 17:17:04 +0200
Subject: [PATCH] net: macb: set interface name based on DT aliases
In-Reply-To: <20140505204022.GA27961@quad.lixom.net>
References: <1394620196-6295-1-git-send-email-b.brezillon.dev@gmail.com>
 <20140505204022.GA27961@quad.lixom.net>
Message-ID: <5368FCF0.90508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 05/05/2014 22:40, Olof Johansson wrote:
> On Wed, Mar 12, 2014 at 11:29:56AM +0100, Boris BREZILLON wrote:
>> Use aliases to set the interface name (ethX) instead of automatic
>> assignement.
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
>> ---
>>
>> Hello Nicolas, Jean-Christophe,
>>
>> This is an example on how we could set the ethernet interface id based on DT
>> aliases.
>> As you can see this patch is not properly separated.
>>
>> I'm still not happy with this approach for several reasons:
>> 1) If another ethernet iface has already been registered with the same id the
>>    net dev registration will fail.
>> 2) We bypass the ethernet macros/functions and directly use the net device
>>    functions which IMHO is not future proof.
> [Sorry for the late reply, going through old backlog of unread email]
>
> Looks like this should live in networking core instead of in the driver, it's
> how we handle it in other subsystems.

Sure.
This version was just a quick an dirty hack, but I'll send a new version
integrating this functionality in netdev core.

> I don't know what DaveM's opinions on that is though.

I'll put him in Cc of the next version.

Best Regards,

Boris
