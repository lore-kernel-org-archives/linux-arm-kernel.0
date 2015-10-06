From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 06 Oct 2015 11:42:40 -0700
Subject: [PATCH 3.10-3.17] ARM: orion: Fix DSA platform device after mvmdio
 conversion
In-Reply-To: <87wpv09ihm.fsf@free-electrons.com>
References: <1443902628-7861-1-git-send-email-f.fainelli@gmail.com>	<1443902628-7861-2-git-send-email-f.fainelli@gmail.com>
 <87wpv09ihm.fsf@free-electrons.com>
Message-ID: <56141620.1010900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/15 07:31, Gregory CLEMENT wrote:
> Hi Florian,
>  
>  On sam., oct. 03 2015, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> DSA expects the host_dev pointer to be the device structure associated
>> with the MDIO bus controller driver. First commit breaking that was
>> c3a07134e6aa ("mv643xx_eth: convert to use the Marvell Orion MDIO
>> driver"), and then, it got completely under the radar for a while.
>>
>> Reported-by: Frans van de Wiel" <fvdw@fvdw.eu>
>> Fixes: c3a07134e6aa ("mv643xx_eth: convert to use the Marvell Orion MDIO driver")
>> CC: stable at vger.kernel.org
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> This patch is for -stable kernels 3.10 to 3.17 (included)
> 
> is it something expected by the stable team?
> 
> I though that the normal flow was to send a fix, applying it on the
> current kernel and from this point the stable team try to apply it on
> all the relevant kernel. And only when the patch failed to apply you
> have to send them a port of the patch for the given version.
> 
> Here you anticipate it, I find it intersting, but I wonder if it fits in
> the stable team workflow.

Yes, I am not too sure about that, the commit message is wrong anyway,
since it references the new, and not the old member name, maybe it is
just best to wait for the fix to hit the mainline tree, and when this
patch gets scheduled for -stable inclusion, I will re-submit a proper
one that applies to 3.10 through 3.17?

The other intent of this "double" submission was for people like Frans
who reported the issue on a specific kernel, to be able to get it in
their inbox so can test that patch.
-- 
Florian
