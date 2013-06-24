From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 24 Jun 2013 12:07:18 +0530
Subject: [PATCH v7 1/9] drivers: phy: add generic PHY framework
In-Reply-To: <51C0CFAC.9080606@gmail.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-2-git-send-email-kishon@ti.com> <51C0CFAC.9080606@gmail.com>
Message-ID: <51C7E91E.3030303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013 02:52 AM, Sylwester Nawrocki wrote:
> Hi Kishon,
>
> I've noticed there is a little inconsistency between the code and documentation.
>
> On 06/13/2013 10:43 AM, Kishon Vijay Abraham I wrote:
>> +3. Creating the PHY
>> +
>> +The PHY driver should create the PHY in order for other peripheral controllers
>> +to make use of it. The PHY framework provides 2 APIs to create the PHY.
>> +
>> +struct phy *phy_create(struct device *dev, int id, const struct phy_ops *ops,
>> +    void *priv);
>> +struct phy *devm_phy_create(struct device *dev, int id,
>> +    const struct phy_ops *ops, void *priv);
>
> The 'label' argument is missing in those function prototypes. It seems the
> labels must be unique, I guess this needs to be documented. And do we allow
> NULL labels ? If so, then there is probably a check for NULL label needed
> in phy_lookup() and if not, then phy_create() should fail when NULL label
> is passed ?

Yeah. Label is used only for non-dt case so NULL should be allowed while 
phy_create().

Thanks
Kishon
