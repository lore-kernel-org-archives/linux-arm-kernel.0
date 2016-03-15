From: julien.grall@arm.com (Julien Grall)
Date: Tue, 15 Mar 2016 12:26:29 +0000
Subject: [PATCH v3 5/9] irqchip/gic-v3: Gather all ACPI specific data in a
 single structure
In-Reply-To: <20160309053930.GH26583@lvm>
References: <1457436573-6180-1-git-send-email-julien.grall@arm.com>
 <1457436573-6180-6-git-send-email-julien.grall@arm.com>
 <20160309053930.GH26583@lvm>
Message-ID: <56E7FF75.7060701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 09/03/16 05:39, Christoffer Dall wrote:
> On Tue, Mar 08, 2016 at 11:29:29AM +0000, Julien Grall wrote:
>> Even though all the variables aren't marked with __initdata, they are
>> only used during initialization. So the structure is marked with
>> __initdata.
>
> Not sure I understand this commit message.
>
> As I see it, this commit includes two changes:
>
> 1. Mark the variables only used during init with __initdata
>
> 2. Move the variables into a structure
>
> If I get that right, can you argue for both changes?

What about:

"The ACPI code requires to use global variables in order to collect 
information from the tables.

To make clear those variables are ACPI specific, gather all of them in a 
single structure.

Furthermore, even if some of the variables are not marked with 
__initdata, they are all only used during the initialization. Therefore, 
the new variable, which hold the structure, can be marked __initdata."

Cheers,

-- 
Julien Grall
