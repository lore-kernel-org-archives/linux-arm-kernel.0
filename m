From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Fri, 7 Nov 2014 10:31:20 -0600
Subject: [PATCHv3 4/5] edac: altera: Add Altera L2 Cache and OCRAM EDAC
 Support
In-Reply-To: <20141106163134.GF4318@pd.tnic>
References: <1414683131-20786-1-git-send-email-tthayer@opensource.altera.com>
 <1414683131-20786-5-git-send-email-tthayer@opensource.altera.com>
 <20141104151214.GD9570@pd.tnic> <545959E8.2040005@opensource.altera.com>
 <20141106163134.GF4318@pd.tnic>
Message-ID: <545CF3D8.1020500@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 11/06/2014 10:31 AM, Borislav Petkov wrote:
> Hi Thor,
> 
> On Tue, Nov 04, 2014 at 04:57:44PM -0600, Thor Thayer wrote:
>> We want to at least separate L2/OCRAM ECC from the SDRAM ECC because
>> 1) the SDRAM preparation can take almost 2 seconds on boot and some
>> customers need a faster boot time.
>> 2) the SDRAM has an ECC initialization dependency on the preloader which is
>> outside the kernel. It is desirable to be able to turn the SDRAM on & off
>> separately.
> 
> Well, now that I asked and you gave valid reasons for the split,
> you should keep them split the way they are. But please do add that
> explanation to the commit message so that it is clear to people why
> there is a split.
> 
>> You bring up a good point about the L2 and OCRAM being combined though.
>>
>> If we do want granular control, maybe I should use a submenu? Or isn't that
>> desirable either?
> 
> Well, what do you think would be easier/faster for a user configuring? A
> separate menu where you have to do a couple of key presses just to enter
> it or simply a subtree in Kconfig with all the options together. I think
> the "depends" gives you that already...
> 
> Ok, once you've worked in the suggested changes, you're good to go,
> at least for the EDAC bits. Let me know how you want to handle this,
> whether I should pick up the whole thing or I should ack the EDAC parts.
> This patchset should go together, in any case, and so I don't care
> whoever picks it up.
> 

If it's okay, can you please pick up this series, once everything is
cleaned up? I just checked to make sure that there aren't any merge
conflicts in the DTS files in this series against DTS patches that I
have queue up for 3.19, and there aren't.

Thanks,
Dinh
