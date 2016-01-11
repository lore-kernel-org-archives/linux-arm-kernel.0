From: brijesh.singh@amd.com (Brijesh Singh)
Date: Mon, 11 Jan 2016 10:55:54 -0600
Subject: [PATCH] ata: add AMD Seattle platform driver
In-Reply-To: <5693CB41.70408@redhat.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
 <4983521.tEaWggKCCv@wuerfel> <568F14E0.4060107@amd.com>
 <10869853.plxna0HzWE@wuerfel> <5690367E.8060609@amd.com>
 <5693CB41.70408@redhat.com>
Message-ID: <5693DE9A.9070101@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On 01/11/2016 09:33 AM, Mark Langsdorf wrote:
> On 01/08/2016 04:21 PM, Brijesh Singh wrote:
>>
>> libata-*.c implements the "Enclosure management" style led messages but also has hooks
>> to register a custom led control callback. Since Seattle platform does not support
>> the "Enclosure management" registers hence ata_port_info we are setting a ATA_FLAG_EM | ATA_FLAG_SW_ACIVITY
>> to indicate that we can still handle the led messages by our registered callback. I see
>> that sata_highbank driver is doing something similar.
> 
> The sata_highbank driver is doing it wrong and shouldn't have been
> accepted in its current condition. Enclosure management really should
> be a separate device. Please don't use it as an example.
> 

Okay. Thanks for letting me know.

Should I consider extending the generic driver to handle this Seattle platform specific feature or go with a new
platform driver approach (i.e the one I am doing right now) ? 

-Brijesh
