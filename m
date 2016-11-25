From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 25 Nov 2016 09:52:28 +0000
Subject: [PATCH 5/7] efi: Get the secure boot status [ver #3]
In-Reply-To: <15173.1480066220@warthog.procyon.org.uk>
References: <147990561294.7576.6464430479448167484.stgit@warthog.procyon.org.uk>
 <147990565051.7576.9673287945782426886.stgit@warthog.procyon.org.uk>
 <1480016487.2444.18.camel@HansenPartnership.com>
 <15173.1480066220@warthog.procyon.org.uk>
Message-ID: <CAKv+Gu_JxNLDjaK5jGbX9ACzM0uHJYMOFx7XDo4t7DtBMtFRGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2016 at 09:30, David Howells <dhowells@redhat.com> wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>
>> Since you seem to be using this to mean "is the platform locked down?",
>> this looks to be no longer complete in the UEFI 2.6 world.  If
>> DeployedMode == 0, even if SecureBoot == 1 and SetupMode == 0, you can
>> remove the platform key by writing 1 to AuditMode and gain control of
>> the secure variables.  The lock down state becomes DeployedMode == 1,
>> SecureBoot == 1 and SetupMode == 0
>>
>> See the diagram on page 1817
>>
>> http://www.uefi.org/sites/default/files/resources/UEFI%20Spec%202_6.pdf
>
> How many pages?!
>
> Does the DeployedMode variable not exist in older versions of the UEFI spec?
>

No, it was added in 2.6
