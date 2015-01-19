From: jcm@redhat.com (Jon Masters)
Date: Sun, 18 Jan 2015 22:35:47 -0500
Subject: =?gbk?Q?=B4=F0=B8=B4=3A_=5BPATCHv4=5D_arm64=3A_dmi=3A_?=
 =?gbk?Q?Add_SMBIOS/DMI_support?=
In-Reply-To: <54BC7A52.6040006@redhat.com>
References: <1412437603-3394-1-git-send-email-yi.li@linaro.org>
 <54B9F9D2.6000104@redhat.com> <20150117121247.GL3827@bivouac.eciton.net>
 <54BA7B0E.5020207@redhat.com>
 <D0F5605BA99F0B4594FB1EEC24E785CC6549F905@SZXEMA510-MBX.china.huawei.com>
 <54BC7A52.6040006@redhat.com>
Message-ID: <54BC7B93.3090306@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2015 10:30 PM, Jon Masters wrote:
> On 01/18/2015 08:27 PM, liyi 00215672 wrote:
>> Hi Jon, Leif,
>>
>> 	I am reviving with phoenix.liyi at huawei.com :)
>>
>> 	Agreed with Leif, The DMI/SMBIOS data are available for user space not for kernel level on x86, which means if DMI has some bad descriptions, it should not affect the kernel boot normally.
>>
>> 	So ARM platform will do the same thing, DMI data just as a reference for system configuration, and don't depend them to boot the sytem. :)
>>
>> 	Thanks!
> 
> Thanks for the feedback! Looking forward to another visit to Shenzen soon :)
> 
> I'm afraid I think we'll need to use the socket information in DMI to
> populate topology in the short term or for a vendor kernel or two. It's
> important that certain tooling accurately account the number of sockets
> present. It's awesome that ARM is going multi-socket. It's less awesome
> to see the magic words "IMPLEMENTATION DEFINED". That always means
> "abandon all hope ye who enter here". It'll need fixing in the form of a
> rigidly defined standard.
> 
> I've just spent the weekend going through a variety of vendor tables and
> manually validating/correcting them/harassing people to fix various ones
> or convert to SMBIOS3. Depending upon how well this goes, we might be in
> a position to have usable data for now. With a few sanity checks, we can
> avoid using the data if it is incorrect. And in the medium term, we will
> work on a better solution such as adding topology description to ACPI
> tables. Then, we'll come back to this thread to see what is good
> upstream, once we've some informed data about what is a practical solution.

Quick footnote that I have an *embarrassingly hackish* kludged version
of dmidecode that understands how to read SMBIOS3 tables from /dev/mem
and it's working on various hardware here (using it to sanity check
vendor tables and provide feedback). I'll share a patch if useful
off-list, but I'm waiting on Linaro to post the /sys/firmware/dmi patch
this week for the solution we'd like to see in the tools upstream.

Jon.
