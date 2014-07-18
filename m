From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Jul 2014 20:47:07 -0600
Subject: [GIT PULL 1/3] ARM: tegra: rework PCIe regulators
In-Reply-To: <20140707003854.GD8469@quad.lixom.net>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <20140707003854.GD8469@quad.lixom.net>
Message-ID: <53C88AAB.9010809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2014 06:38 PM, Olof Johansson wrote:
> On Mon, Jun 23, 2014 at 03:23:44PM -0600, Stephen Warren wrote:
>> This branch reworks the set of regulators that the Tegra PCIe driver
>> uses, so that the driver and DT bindings more correctly model what's
>> really going on in HW.
>>
>> I've made this a separate branch in case it needs to be pulled into the
>> PCIe tree to resolve any conflicts. Any branch that adds Tegra124
>> support to the PCIe driver will need to be based on this branch, and
>> such patches might show up for 3.17, and be taken through the ARM tree
>> so we can manage our own dependencies.
> 
> Isn't PCI broken if you boot with an older device tree now?
> 
> I would like to see this as two branches: One to the PCI driver, and one
> modifying DT contents. The PCI driver should remain working for old DTs,
> so the last couple of commits on this branch can't be there.

I thought it was still completely legal to change DT bindings that were
not yet considered stable. None of the Tegra bindings have yet been
deemed stable.
